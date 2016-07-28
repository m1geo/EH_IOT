function [ kl ] = normals(a, b, c, d, xvar, pshist, figures, txt)

%global figurenumber

g1 = (a(1)*normpdf(xvar,a(2),a(3)));
g2 = (b(1)*normpdf(xvar,b(2),b(3)));
g3 = (c(1)*normpdf(xvar,c(2),c(3)));
g4 = (d(1)*normpdf(xvar,d(2),d(3)));

fittedpdf = g1 + g2 + g3 + g4;

kl = KLDiv(pshist(pshist>0), fittedpdf(pshist>0));
%kl = mean((pshist(pshist>0) - fittedpdf(pshist>0)).^2);

if (figures>0)
    figure
    semilogy(xvar(pshist>0),pshist(pshist>0), 'b', 'LineWidth',2)
    hold on
    semilogy(xvar(pshist>0),fittedpdf(pshist>0), 'r', 'LineWidth',2)
    hold off
    if (figures>1)
        hold on
        tone = 0.5;
        plot(xvar(pshist>0),g1(pshist>0), 'Color', [tone tone tone])
        plot(xvar(pshist>0),g2(pshist>0), 'Color', [tone tone tone])
        plot(xvar(pshist>0),g3(pshist>0), 'Color', [tone tone tone])
        plot(xvar(pshist>0),g4(pshist>0), 'Color', [tone tone tone])
        hold off
    end
    ylabel('Frequency')
    xlabel('Energy (Watt)')
    title([txt ' (D_{KL}=' num2str(kl) ')'])
    %refreshdata
    %drawnow
end

end
